import * as React from 'react';
import { PageSection, Title } from '@patternfly/react-core';

const Dashboard: React.FunctionComponent = () => {
  const [fooData, setFooData] = React.useState<Record<string, unknown>>({});

  React.useEffect(() => {
    fetch('/api/foo')
      .then((res) => res.json())
      .then((data) => setFooData(data));
  }, []);

  return (
    <PageSection>
      <Title headingLevel="h1" size="lg">
        Dashboard Page Title!
      </Title>
      Mock service worker test response:
      <pre>{JSON.stringify(fooData, null, 2)}</pre>
    </PageSection>
  );
};

export { Dashboard };

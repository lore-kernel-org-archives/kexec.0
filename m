Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lSH0o-00Ck8h-0M
 for kexec@lists.infradead.org; Fri, 02 Apr 2021 10:26:51 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH kexec-tools 0/7] build enhancements and GitHub workflow
Date: Fri,  2 Apr 2021 12:17:30 +0200
Message-Id: <20210402101737.1886-1-horms@verge.net.au>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>

This series aimes to:

1. Allow creation of dist tarball without self-referential hard links
2. Add a distckeck target
3. Add a GitHub workflow which to performs basic build testing

A sample run of the workflow can be seen here
https://github.com/horms/kexec-tools/actions/runs/711376088

Simon Horman (7):
  build: create tarball without self-referential hard links
  build: add dist make target
  build: uninstall kexec_test
  build: use DESTDIR in uninstall target
  build: simplify uninstall target
  build: add distcheck target
  github: initial workflow

 .github/workflows/build.yml |  72 ++++++++++++++++++
 Makefile.in                 | 141 +++++++++++++++++-------------------
 configure.ac                |   1 +
 3 files changed, 141 insertions(+), 73 deletions(-)
 create mode 100644 .github/workflows/build.yml

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

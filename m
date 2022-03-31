From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 31 Mar 2022 13:59:32 +0800
Subject: [PATCH 0/2] misc improvement of code
Message-ID: <20220331055934.13608-1-piliu@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org


Cc: Simon Horman <horms@verge.net.au>
To: kexec@lists.infradead.org

Pingfan Liu (2):
  arm64/crashdump-arm64: explicit type conversion to suppress compiler
    warning
  kexec/elf: assign one to align if sh_addralign equals zero

 kexec/arch/arm64/crashdump-arm64.c |  2 +-
 kexec/kexec-elf-rel.c              | 10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.31.1



Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i18KI-0007hd-Tl
 for kexec@lists.infradead.org; Fri, 23 Aug 2019 12:05:56 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 0/4 v2] Limit the size of vmcore-dmesg.txt to 2G
Date: Fri, 23 Aug 2019 20:05:35 +0800
Message-Id: <20190823120539.18330-1-lijiang@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: kasong@redhat.com, bhe@redhat.com, piliu@redhat.com, bhsharma@redhat.com, junw99@yahoo.com, horms@verge.net.au, dyoung@redhat.com

[PATCH 1/4] Cleanup: remove the read_elf_kcore()
Here, no need to wrap the read_elf() again, lets invoke it directly.
So remove the read_elf_kcore() and clean up redundant code.

[PATCH 2/4] Fix an error definition about the variable 'fname'
The variable 'fname' is mistakenly defined two twice, the first definition
is in the vmcore-dmesg.c, and the second definition is in the elf_info.c.
That is confused and incorrect although it's a static type, because the
value of variable 'fname' is not assigned(set) in elf_info.c. Anyway, its
value will be always 'null' when printing an error information.

[PATCH 3/4] Cleanup: move it back from util_lib/elf_info.c
Some code related to vmcore-dmesg.c is put into the util_lib, which
is not very reasonable, so lets move it back and tidy up those code.
In addition, that will also help to limit the size of vmcore-dmesg.txt.

[PATCH 4/4] Limit the size of vmcore-dmesg.txt to 2G
With some corrupted vmcore files, the vmcore-dmesg.txt file may
grow forever till the kdump disk becomes full. Lets limit the
size of vmcore-dmesg.txt to avoid such problems.

BTW: I tested this patch series on x86 64 and arm64, it also worked well.

Changes since v1:
[1] split them([patch 1/4] and [patch 2/4]) into a separate patch.
[2] remove a typedef definition for handler.
[3] remove some changes of variable 'fname' and fix its error.

Lianbo Jiang (4):
  Cleanup: remove the read_elf_kcore()
  Fix an error definition about the variable 'fname'
  Cleanup: move it back from util_lib/elf_info.c
  Limit the size of vmcore-dmesg.txt to 2G

 kexec/arch/arm64/kexec-arm64.c |  2 +-
 util_lib/elf_info.c            | 65 ++++++++--------------------------
 util_lib/include/elf_info.h    |  4 +--
 vmcore-dmesg/vmcore-dmesg.c    | 42 ++++++++++++++++++++--
 4 files changed, 57 insertions(+), 56 deletions(-)

-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

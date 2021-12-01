Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1msPxh-008slg-J3
 for kexec@lists.infradead.org; Wed, 01 Dec 2021 13:47:55 +0000
Received: by mail-ed1-x533.google.com with SMTP id e3so101986281edu.4
 for <kexec@lists.infradead.org>; Wed, 01 Dec 2021 05:47:52 -0800 (PST)
From: Ivan Khoronzhuk <ivan.khoronzhuk@gmail.com>
Subject: [RFC PATCH] makedumpfile: add userinfo elf section 0/4]
Date: Wed,  1 Dec 2021 15:47:26 +0200
Message-Id: <20211201134730.15943-1-ikhoronz@cisco.com>
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
To: k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: Ivan Khoronzhuk <ikhoronz@cisco.com>

These patchset suggests feature to add user specific information along
with dumpfile. One of usecases could be a platform build information
containing dubug file addresses, sources of daily build, some
platform related information and more, it's gracefully simplifies
debugging process, since an engineer doesn't need to spend time on
finding to which platform this core file is related, where to get
debugging counter part and so on. As user info can be added along with
dumpfile it frees platform from creating tar achieve spending doubled
space or using specific tools. Since this information is sorted and
selected by user it can't be standardized and should be placed in some
special generic section. This patchset roughly proposes the variant when
user information is placed/retrieved as subsection of note elf
section.

Ivan Khoronzhuk (4):
  makedumpfile: rename check_dump_file() on check_file_is_writable()
  elf: add new "userinfo" ELF section to traverse debug information
  elf_info: make int note_descsz() and offset_next_note() public
  elf: add ability to read the userinfo data from note segment

 elf_info.c     |   4 +-
 elf_info.h     |   5 +
 makedumpfile.c | 393 ++++++++++++++++++++++++++++++++++++++++++++++++-
 makedumpfile.h |  12 ++
 4 files changed, 404 insertions(+), 10 deletions(-)

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1msPxk-008sn9-Fw
 for kexec@lists.infradead.org; Wed, 01 Dec 2021 13:47:57 +0000
Received: by mail-ed1-x530.google.com with SMTP id r11so102119819edd.9
 for <kexec@lists.infradead.org>; Wed, 01 Dec 2021 05:47:56 -0800 (PST)
From: Ivan Khoronzhuk <ivan.khoronzhuk@gmail.com>
Subject: [RFC makedumpfile: add userinfo elf section 3/4] elf_info: make int
 note_descsz() and offset_next_note() public
Date: Wed,  1 Dec 2021 15:47:29 +0200
Message-Id: <20211201134730.15943-4-ikhoronz@cisco.com>
In-Reply-To: <20211201134730.15943-1-ikhoronz@cisco.com>
References: <20211201134730.15943-1-ikhoronz@cisco.com>
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

These usefule funcgtions are supposed to be reused in makedumfile note
travese procedures.

Signed-off-by: Ivan Khoronzhuk <ikhoronz@cisco.com>
---
 elf_info.c | 4 ++--
 elf_info.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/elf_info.c b/elf_info.c
index bc24083..0737b6c 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -181,7 +181,7 @@ dump_Elf_load(Elf64_Phdr *prog, int num_load)
 	return TRUE;
 }
 
-static off_t
+off_t
 offset_next_note(void *note)
 {
 	off_t offset;
@@ -240,7 +240,7 @@ note_namesz(void *note)
 	return size;
 }
 
-static int
+int
 note_descsz(void *note)
 {
 	int size;
diff --git a/elf_info.h b/elf_info.h
index ca96935..f38605d 100644
--- a/elf_info.h
+++ b/elf_info.h
@@ -74,6 +74,8 @@ int get_nr_cpus(void);
 int has_pt_note(void);
 void set_pt_note(off_t offset, unsigned long size);
 void get_pt_note(off_t *offset, unsigned long *size);
+int note_descsz(void *note);
+off_t offset_next_note(void *note);
 
 int has_vmcoreinfo(void);
 void set_vmcoreinfo(off_t offset, unsigned long size);
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

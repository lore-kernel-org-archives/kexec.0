Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bsrJP-0005dI-4Z
 for kexec@lists.infradead.org; Sat, 08 Oct 2016 13:05:11 +0000
Received: by mail-ua0-x242.google.com with SMTP id m26so2755274uaa.2
 for <kexec@lists.infradead.org>; Sat, 08 Oct 2016 06:04:50 -0700 (PDT)
MIME-Version: 1.0
From: Sagar Borikar <sagar.borikar@gmail.com>
Date: Sat, 8 Oct 2016 06:04:28 -0700
Message-ID: <CAFwMWxs_r3VyBqE+r6VsLv1-Y=oxby=24NJ_+jEWShbEmdrfQA@mail.gmail.com>
Subject: MIPS little endian support for kexec-tools
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

Hi,

I am porting kexec on MIPS CPU which is running in little endian mode.
While setting up kexec, I see that the definitions of crash elf
headers are only for big endian MIPS. The elf header populated by the
crashdump-mips.c is for big endian.
Is there support for little endian MIPS in kexec tools?

Thanks
Sagar

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

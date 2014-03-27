Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ve0-x235.google.com ([2607:f8b0:400c:c01::235])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WT2lR-00043t-1u
 for kexec@lists.infradead.org; Thu, 27 Mar 2014 05:22:05 +0000
Received: by mail-ve0-f181.google.com with SMTP id oy12so3605586veb.12
 for <kexec@lists.infradead.org>; Wed, 26 Mar 2014 22:21:43 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 26 Mar 2014 22:21:43 -0700
Message-ID: <CAGXD9OcGpWC-dTgk9tr4DaUfLbdbYLq7mEWc9BtXWiuqzX32sw@mail.gmail.com>
Subject: access memblock_alloc()ed memory inside vmcore-dmesg
From: Prasad Koya <prasad.koya@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi

I'm passing kernel cmdline log_buf_len to increase dmesg buffer size.
This causes kernel to make log_buf use memblock_alloc()ed memory and
orphan __log_buf. How do I access memblock_alloc()ed memory in
vmcore-dmesg? With existing kexec tools, I get this error:

No program header covering vaddr 0xffff88024ff00000found kexec bug?

Appreciate any pointers. I can work on it and send the code for review.

Thank you.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O2Abs-0000eY-VA
	for kexec@lists.infradead.org; Wed, 14 Apr 2010 21:59:01 +0000
Received: by bwz5 with SMTP id 5so742903bwz.20
	for <kexec@lists.infradead.org>; Wed, 14 Apr 2010 14:58:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100414152231.GA16779@a1.tnic>
References: <alpine.DEB.2.00.1004132147260.1881@parag-laptop>
	<20100414061746.GA23153@liondog.tnic>
	<alpine.LFD.2.00.1004140712240.15116@i5.linux-foundation.org>
	<20100414152231.GA16779@a1.tnic>
Date: Wed, 14 Apr 2010 17:58:57 -0400
Message-ID: <l2yf7848161004141458k5ff49eefs4c1871e2157df9d5@mail.gmail.com>
Subject: Re: 2.6.34-rc4 : OOPS in unmap_vma
From: Parag Warudkar <parag.lkml@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Parag Warudkar <parag.lkml@gmail.com>, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, kexec@lists.infradead.org

Hi Borislav

On Wed, Apr 14, 2010 at 11:22 AM, Borislav Petkov <bp@alien8.de> wrote:

> interesting what he means there - a kexec-enabled kernel or is this the
> "second" kernel his machine kexec'd into after a previous failure. I
> think this could clarify the situation a bit.
>

It was the kexec'ed kernel that oopsed - the first kernel had no issues.
It was kexec'ing from 2.6.34-rc4 to the same kernel.

After that I have tried to reboot via kexec to try to reproduce the
issue but it either hung completely or resulted in corrupted X and
non-moving cursor.
Kexec from Distro kernel to itself works just fine (Ubuntu 2.6.32-20) however.

I will start a bisect as soon as find time.

Parag

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

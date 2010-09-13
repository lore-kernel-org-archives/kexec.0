Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ww0-f49.google.com ([74.125.82.49])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Ov7sL-0007Fi-8e
	for kexec@lists.infradead.org; Mon, 13 Sep 2010 12:11:09 +0000
Received: by wwb24 with SMTP id 24so6972163wwb.18
	for <kexec@lists.infradead.org>; Mon, 13 Sep 2010 05:11:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100909081656.GL19303@verge.net.au>
References: <20100907151025.5784.98190.stgit@muvarov>
	<20100909081656.GL19303@verge.net.au>
Date: Mon, 13 Sep 2010 16:11:06 +0400
Message-ID: <AANLkTi=qvs8dDL8oSvczgoMB_K1ymrV7OrJr=Lzug0dW@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "powerpc new toolchains fix (crt.S)"
From: Maxim Uvarov <muvarov@gmail.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

2010/9/9 Simon Horman <horms@verge.net.au>:
> On Tue, Sep 07, 2010 at 07:10:25PM +0400, Maxim Uvarov wrote:
>> This reverts commit 45e8f29639d9f97b74389e5bd28c7a5cccbf3e2a.
>> purgatory/arch/ppc/crt.S and purgatory/arch/ppc/misc.S are the same
>> files.
>
> Thanks, applied both patches.
>

Thanks, we had some misunderstanding there and committed 3 patches
instead of one.
But now crt.S is out of the tree and it is ok. Powerpc code is
compilable without any specific
options.

-- 
Best regards,
Maxim Uvarov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

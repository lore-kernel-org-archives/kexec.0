Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d58y2-0006Yu-Ne
 for kexec@lists.infradead.org; Mon, 01 May 2017 10:54:13 +0000
Received: by mail-pg0-f54.google.com with SMTP id v1so43822297pgv.1
 for <kexec@lists.infradead.org>; Mon, 01 May 2017 03:53:49 -0700 (PDT)
Subject: Re: Running kexec, kernel gets stuck at "Starting new kernel"
References: <1fafe0dceb744c8587c3b3a398b46321@LPHQEX2013.litepoint.internal>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <626fa54e-8a7e-8131-b453-6ef389c10a77@redhat.com>
Date: Mon, 1 May 2017 16:23:45 +0530
MIME-Version: 1.0
In-Reply-To: <1fafe0dceb744c8587c3b3a398b46321@LPHQEX2013.litepoint.internal>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Rudici Cazeao <rudici.cazeao@litepoint.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>



On Friday 28 April 2017 07:20 AM, Rudici Cazeao wrote:
> I am running kexec in consecutive loops on 4 different dual-core arm processors.  On 3 of these processors, usually, somewhere between the 500th and the 5000th loop, the kernel gets stuck at "Starting new kernel". On the remaining processor, kexec is run over and over without running into this issue. And this appears to be pretty consistent. Any ideas?
>
> Also, on rare occasions, the kernel gets stuck at " Uncompressing Linux... done, booting the kernel".

Try to look for earlycon or earlyprintk setting for your board, and pass that 
in "--append=" of kexec. You will have more information about the failed 
component.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

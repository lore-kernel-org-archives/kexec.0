Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJxuL-0001je-OO
 for kexec@lists.infradead.org; Fri, 26 Apr 2019 10:16:42 +0000
Date: Fri, 26 Apr 2019 18:16:35 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [RFC PATCH] kexec, x86/boot: map systab region in identity
 mapping before accessing it
Message-ID: <20190426101635.GQ3584@localhost.localdomain>
References: <20190419101733.GA10324@zn.tnic>
 <20190419105014.GE11060@MiWiFi-R3L-srv>
 <20190419112801.GB10324@zn.tnic> <20190419113621.GD10324@zn.tnic>
 <20190422143346.GD3584@localhost.localdomain>
 <20190422151723.GD21457@zn.tnic>
 <20190426095134.GP3584@localhost.localdomain>
 <20190426095800.GB4608@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190426095800.GB4608@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: "x86@kernel.org" <x86@kernel.org>, Kairui Song <kasong@redhat.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Thomas Gleixner <tglx@linutronix.de>, dyoung@redhat.com

On 04/26/19 at 11:58am, Borislav Petkov wrote:
> On Fri, Apr 26, 2019 at 05:51:34PM +0800, Baoquan He wrote:
> > I can make a patch to add a bit into xloadflags, to indicate that this
> > is kexec-ed kernel. It can help to differentiate kexec-ed kernel from
> > kdump kernel.
> 
> From the recent snafu, the only thing we needed is to differentiate
> between the *first* kernel and the following kernel(s) which has been
> started/loaded using a kexec syscall.

OK. To make sure I got it, the loader type 0xD is enough for this, right? 

It's fine to me, we can add it later if needed. I remember there's an
issue in intel/amd iommu, in which we need differentiate between
kexec/kdump kernel, but not very sure. I will check it when I have time
to work on that.

Thanks
Baoquan



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fFWD5-0006Pb-U8
 for kexec@lists.infradead.org; Mon, 07 May 2018 02:49:09 +0000
Date: Mon, 7 May 2018 10:48:33 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/2] kdump/x86: crashkernel=X try to reserve below 896M
 first then below 4G and MAXMEM
Message-ID: <20180507024833.GA3895@dhcp-128-65.nay.redhat.com>
References: <20180427090045.532014306@redhat.com>
 <20180427091410.GA25338@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180427091410.GA25338@dhcp-128-65.nay.redhat.com>
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
To: akpm@linux-foundation.org
Cc: bhe@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, yinghai@kernel.org, vgoyal@redhat.com

On 04/27/18 at 05:14pm, Dave Young wrote:
> Hi,
>  
> This is a resend of below patches:
> http://lists.infradead.org/pipermail/kexec/2017-October/019569.html
>  
> I dropped the original patch 1 since Baoquan is not happy with it.
> For patch 2 (the 1st patch in this series), there is some improvement
> comment from Baoquan to create some generic memblock iteration function.
> But nobody has time to work on it for the time being.  According to
> offline discussion with him.  That can be done in the future if someone
> is interested.  We can go with the current kdump only fixes.
>  
> Other than above,  the patches are just same.

Hi Andrew, do you have concerns about the patches?  It has been used for
long time in Red Hat kernel, since people do not object them, could you
pick them if no other concerns?

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

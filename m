Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fCCnm-0008Up-Ak
 for kexec@lists.infradead.org; Fri, 27 Apr 2018 23:29:19 +0000
Date: Sat, 28 Apr 2018 07:28:43 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/2] kdump/x86: crashkernel=X try to reserve below 896M
 first then below 4G and MAXMEM
Message-ID: <20180427232843.GA30581@MiWiFi-R3L-srv>
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
To: Dave Young <dyoung@redhat.com>
Cc: yinghai@kernel.org, akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

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

Thanks to work on this. Looks good to me.

ACK

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

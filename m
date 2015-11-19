Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZzFME-0004S1-Ep
 for kexec@lists.infradead.org; Thu, 19 Nov 2015 02:53:59 +0000
Date: Thu, 19 Nov 2015 10:53:23 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: How to understand "high" or "low" in crashkernel configuration?
Message-ID: <20151119025323.GA6022@dhcp-128-65.nay.redhat.com>
References: <CA+MhoaMjeVODU_zt=8OoU4zAzBt6hA219=44kee+FR3Ew_v3Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+MhoaMjeVODU_zt=8OoU4zAzBt6hA219=44kee+FR3Ew_v3Vw@mail.gmail.com>
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
To: Nan Xiao <xiaonan830818@gmail.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org

On 11/18/15 at 10:45pm, Nan Xiao wrote:
> Hi all,
> 
> When I use SuSE default Kdump configuration, I find there is "high" or "low" in
> crashkernel's value, and it likes this:
> 
>     crashkernel=xxM,high Or crashkernel=xxM,low
> 
> But from this document(https://www.kernel.org/doc/Documentation/kdump/kdump.txt),
> I can't find explanation of "high" or "low". How to understand it?

You can find it in Documentation/kernel-parameters.txt


> 
> Thanks very much in advance!
> 
> Best Regards
> Nan Xiao
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

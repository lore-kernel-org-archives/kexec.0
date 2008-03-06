Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx.4pi.com ([24.172.19.59])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JX90F-00047X-TA
	for kexec@lists.infradead.org; Thu, 06 Mar 2008 05:50:52 +0000
Mime-Version: 1.0
Message-Id: <p06230918c3f535186eb6@[192.168.9.5]>
In-Reply-To: <20080306032432.GA14808@verge.net.au>
References: <p0623090ac3f3b6cfa8b9@[192.168.9.5]>
	<20080305092731.GB3979@verge.net.au>
	<p06230913c3f4655358a8@[192.168.9.5]>
	<20080306032432.GA14808@verge.net.au>
Date: Thu, 6 Mar 2008 00:50:06 -0500
From: "Scott D. Davilla" <davilla@4pi.com>
Subject: Re: bug/patch for i386 EFI boot
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
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

>Thanks that looks great. I'll merge it.
>
>Just for reference, the sign-off line should go at the bottom
>of your description, not underneath the patch. But I'll fix that
>up when I add my sign-off.

Thanks, this was a real bear to find.

>  > And as follow up question. It there any access to
>>  screen_info.orig_video_isVGA besides linking to the kernel? If there
>>  is access to orig_video_isVGA then kexec can setup the screen boot
>>  params as the bootloader intended instead of assuming a default VGA
>>  config. The orig_video_isVGA is the only parameter missing to clone
>>  the initial screen_info information.
>
>I'm sorry but I'm really not the person to ask about that.
>But it does sound like a good idea if it were possible to
>implement.

I'll continue to look into this and see if I can find a good solution.

Scott


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

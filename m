Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.171.30] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KJsLR-0002Oo-8P
	for kexec@lists.infradead.org; Fri, 18 Jul 2008 15:58:09 +0000
Message-ID: <4880BD65.3030907@sgi.com>
Date: Fri, 18 Jul 2008 08:57:25 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: Shrink the time for creating 1st-bitmap
	(Re: problems in kdump kernel if 'maxcpus=1' not specified?)
References: <487D49DC.8040209@sgi.com>	<20080716151240.GB711@redhat.com>	<20080716152544.GD10030@hmsendeavour.rdu.redhat.com>	<20080716162343.GC711@redhat.com>	<20080716170338.GA11654@hmsendeavour.rdu.redhat.com>	<487E4922.9050209@sgi.com>	<487ED1B3.6060803@mxs.nes.nec.co.jp>	<487EE836.7010607@mxs.nes.nec.co.jp>	<487F7CB0.7040902@sgi.com>
	<48801557.1040709@mxs.nes.nec.co.jp>
In-Reply-To: <48801557.1040709@mxs.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0905591204=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

--===============0905591204==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Ken'ichi Ohmichi wrote:
> Hi,
> 
> Jay Lan wrote:
>> Ken'ichi Ohmichi wrote:
>>> Hi Jay,
>>>
>>> Ken'ichi Ohmichi wrote:
>>>> I created the attached patch that makedumpfile does not scan
>>>> memory gap when creating 1st-bitmap. Could you please try it ?
>>>> This patch is for makedumpfile-1.2.6.
>>> I found a bug in the patch I sent before, and I fixed it in the
>>> attached patch. Could you please try this patch ?
>>> Sorry for my mistake.
>> Hi Ken'ichi San,
>>
>> Thanks for your patch. I need to compete for the test machine. Will
>> post new data when i have one.
> 
> I think that new makedumpfile (version 1.2.7) is more useful for you,
> because it includes not only this patch but also the other patch
> shrinking the time for creating bitmap.

I certainly will, Ken'ichi. Thanks!

I am eager to see the new data; unfortunately the test machine is
booked up until 7/29. :(

Regards,
 - jay

> 
> 
> Thanks
> Ken'ichi Ohmichi
> 
> 


--===============0905591204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0905591204==--

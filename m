Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QcBcs-0003lW-CJ
	for kexec@lists.infradead.org; Thu, 30 Jun 2011 07:25:28 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id C152C3EE0BD
	for <kexec@lists.infradead.org>; Thu, 30 Jun 2011 16:25:18 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id AA89445DEF5
	for <kexec@lists.infradead.org>; Thu, 30 Jun 2011 16:25:18 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 8C80E45DEFE
	for <kexec@lists.infradead.org>; Thu, 30 Jun 2011 16:25:18 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7DF4C1DB802F
	for <kexec@lists.infradead.org>; Thu, 30 Jun 2011 16:25:18 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.240.81.133])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 31C5D1DB8046
	for <kexec@lists.infradead.org>; Thu, 30 Jun 2011 16:25:18 +0900 (JST)
Date: Thu, 30 Jun 2011 16:25:07 +0900 (   )
Message-Id: <20110630.162507.183023698.d.hatayama@jp.fujitsu.com>
Subject: Re: [Crash-utility] [RFI] Support Fujitsu's sadump dump format
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20110630145846tachibana@mail.jp.nec.com>
References: <20110630145846tachibana@mail.jp.nec.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: tachibana@mxm.nes.nec.co.jp
Cc: kexec@lists.infradead.org, crash-utility@redhat.com

Hello Tachibana-san,

Thanks for your replying.

From: tachibana@mxm.nes.nec.co.jp
Subject: Re: [Crash-utility] [RFI] Support Fujitsu's sadump dump format
Date: Thu, 30 Jun 2011 14:58:46 +0900

> Hi Hatayama-san,
> 
> On 2011/06/29 12:12:18 +0900, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>> From: Dave Anderson <anderson@redhat.com>
>> Subject: Re: [Crash-utility] [RFI] Support Fujitsu's sadump dump format
>> Date: Tue, 28 Jun 2011 08:57:42 -0400 (EDT)
>> 
>> > 
>> > 
>> > ----- Original Message -----
>> >> Fujitsu has stand-alone dump mechanism based on firmware level
>> >> functionality, which we call SADUMP, in short.
>> >> 
>> >> We've maintained utility tools internally but now we're thinking that
>> >> the best is crash utility and makedumpfile supports the sadump format
>> >> for the viewpoint of both portability and maintainability.
>> >> 
>> >> We'll be of course responsible for its maintainance in a continuous
>> >> manner. The sadump dump format is very similar to diskdump format and
>> >> so kdump (compressed) format, so we estimate patch set would be a
>> >> relatively small size.
>> >> 
>> >> Could you tell me whether crash utility and makedumpfile can support
>> >> the sadump format? If OK, we'll start to make patchset.
> 
> I think it's not bad to support sadump by makedumpfile. However I have 
> several questions.
> - Do you want to use makedumpfile to make an existing file that sadump has 
>   dumped small?

Of couse, it's one of the purposes. It's useful feature.

The first is to translate sadump format into the one crash utility can
recognize. makedumpfile is the standard tool to do it, and if
makdumpfile can support sadump format, I think it is the best.

> - It isn't possible to support the same form as kdump-compressed format 
>   now, is it?

I think it's technically possible but practically impossible. sadump is
a firmware and it is maintained by firmware team.

> - When the information that makedumpfile reads from a note of /proc/vmcore 
>   (or a header of kdump-compressed format) is added by an extension of 
>   makedumpfile, do you need to modify sadump?

Sorry, I've not investigated makedumpfile implementation enough yet.

But if I understand correctly, the current note information contained
in kdump-compressed format is NT_PRSTATUS and VMCOREINFO only, and for
them, sadump doesn't need to be modified. But it might need to be
modified if another kind of note is newly added.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

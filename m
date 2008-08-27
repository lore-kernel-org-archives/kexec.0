Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.246])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KYEvl-0005dr-6T
	for kexec@lists.infradead.org; Wed, 27 Aug 2008 06:55:01 +0000
Received: by rv-out-0708.google.com with SMTP id b17so2308448rvf.42
	for <kexec@lists.infradead.org>; Tue, 26 Aug 2008 23:55:00 -0700 (PDT)
Message-ID: <aec7e5c30808262355w73e2e6b2y47534812758a79a0@mail.gmail.com>
Date: Wed, 27 Aug 2008 15:55:00 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [PATCH 06/06] sh: Add vmlinux support
In-Reply-To: <20080827054043.GO19066@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
References: <20080826111150.615.97501.sendpatchset@rx1.opensource.se>
	<20080826111232.615.24048.sendpatchset@rx1.opensource.se>
	<20080827023905.GL19066@verge.net.au>
	<aec7e5c30808262110p8197b84ieaf38211a495daa0@mail.gmail.com>
	<20080827054043.GO19066@verge.net.au>
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

On Wed, Aug 27, 2008 at 2:40 PM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Aug 27, 2008 at 01:10:30PM +0900, Magnus Damm wrote:
>> Hi Simon,
>>
>> On Wed, Aug 27, 2008 at 11:39 AM, Simon Horman <horms@verge.net.au> wrote:
>> > On Tue, Aug 26, 2008 at 08:12:32PM +0900, Magnus Damm wrote:
>> >> From: Magnus Damm <damm@igel.co.jp>
>> >>
>> >> Add SuperH vmlinux support through a zero-page aware elf loader. Only for
>> >> kexec at this point, in the future kdump support will be added.
>> >
>> > If these series of patches are fine by you then they are fine by me.
>> > I just have a few minor issues with this last patch.
>>
>> How does the attached patch look?
>>
>> Thanks for your help!
>
> Much better :-)
>
> Should I just fold it into the last patch and push ?

Yes, that would be great! Thanks! =)

/ magnus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

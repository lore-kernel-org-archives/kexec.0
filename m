Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c9SkE-0006pg-Vm
 for kexec@lists.infradead.org; Wed, 23 Nov 2016 08:17:32 +0000
Received: by mail-oi0-f45.google.com with SMTP id y198so6512241oia.1
 for <kexec@lists.infradead.org>; Wed, 23 Nov 2016 00:17:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161123080816.GA30255@verge.net.au>
References: <cover.1479788404.git.panand@redhat.com>
 <b1b9e70db9d08364040436154cf0cf2f4600da49.1479788404.git.panand@redhat.com>
 <53ee2a62-7822-5457-e59f-e65e64a57019@infradead.org>
 <54cad725-90f0-8dfe-bee6-fe1d3e02175d@redhat.com>
 <20161123020300.GA3481@dhcp-128-65.nay.redhat.com>
 <81975e6e-b97a-0401-0e18-b2d26722c1dd@redhat.com>
 <20161123080816.GA30255@verge.net.au>
From: Pratyush Anand <panand@redhat.com>
Date: Wed, 23 Nov 2016 13:47:09 +0530
Message-ID: <CAHB_GupoWM5iRPDsyZBEByCsbPARf7OJwyHvvrXLtTCxsJ-0Mw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: Pass RAM boundary and enable-dcache flag to
 purgatory
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
To: Simon Horman <horms@verge.net.au>
Cc: Geoff Levand <geoff@infradead.org>, James Morse <james.morse@arm.com>, Dave Young <dyoung@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Simon,

Thanks for your review comment.

On Wed, Nov 23, 2016 at 1:38 PM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Nov 23, 2016 at 07:41:52AM +0530, Pratyush Anand wrote:
>>
>>
>> On Wednesday 23 November 2016 07:33 AM, Dave Young wrote:
>> >>Although this is very unlikely that a hardware will support only 16K page
>> >>> sizes, however it is possible. Therefore, its better to keep it disabled by
>> >>> default.
>> >If it is *unlikely* it could be better to make it as default and add a
>> >--disable-dcache instead.
>> >
>>
>> I think, I can do that.
>
> Can this be detected at run-time?



Thats doable. OK, so if everyone agrees then I can send a V2 where
neither --enable-dcache nor --disable-dcache will be used. It will
enable dcache if 4K/64K page is supported and will do nothing
otherwise.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

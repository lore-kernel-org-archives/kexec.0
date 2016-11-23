Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c9N2p-00055F-GC
 for kexec@lists.infradead.org; Wed, 23 Nov 2016 02:12:20 +0000
Received: by mail-qk0-f182.google.com with SMTP id q130so50309192qke.1
 for <kexec@lists.infradead.org>; Tue, 22 Nov 2016 18:11:58 -0800 (PST)
Subject: Re: [PATCH 2/2] arm64: Pass RAM boundary and enable-dcache flag to
 purgatory
References: <cover.1479788404.git.panand@redhat.com>
 <b1b9e70db9d08364040436154cf0cf2f4600da49.1479788404.git.panand@redhat.com>
 <53ee2a62-7822-5457-e59f-e65e64a57019@infradead.org>
 <54cad725-90f0-8dfe-bee6-fe1d3e02175d@redhat.com>
 <20161123020300.GA3481@dhcp-128-65.nay.redhat.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <81975e6e-b97a-0401-0e18-b2d26722c1dd@redhat.com>
Date: Wed, 23 Nov 2016 07:41:52 +0530
MIME-Version: 1.0
In-Reply-To: <20161123020300.GA3481@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Geoff Levand <geoff@infradead.org>, james.morse@arm.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org



On Wednesday 23 November 2016 07:33 AM, Dave Young wrote:
>> Although this is very unlikely that a hardware will support only 16K page
>> > sizes, however it is possible. Therefore, its better to keep it disabled by
>> > default.
> If it is *unlikely* it could be better to make it as default and add a
> --disable-dcache instead.
>

I think, I can do that.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cH6YL-0008L0-TM
 for kexec@lists.infradead.org; Wed, 14 Dec 2016 10:12:52 +0000
Received: by mail-qk0-f169.google.com with SMTP id q130so14117328qke.1
 for <kexec@lists.infradead.org>; Wed, 14 Dec 2016 02:12:29 -0800 (PST)
Subject: Re: [PATCH 1/2] arm64: Add enable/disable d-cache support for
 purgatory
References: <cover.1479788404.git.panand@redhat.com>
 <7a4866b928c0905ec1074dce1bfc7984c968a58a.1479788404.git.panand@redhat.com>
 <5838834D.90205@arm.com> <d8f354da-1e61-feaf-f76a-18e90361e98b@redhat.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <9a79b666-7990-2a23-2d74-52b3317ce272@redhat.com>
Date: Wed, 14 Dec 2016 15:42:22 +0530
MIME-Version: 1.0
In-Reply-To: <d8f354da-1e61-feaf-f76a-18e90361e98b@redhat.com>
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
To: James Morse <james.morse@arm.com>
Cc: geoff@infradead.org, Mark Rutland <mark.rutland@arm.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org



On Wednesday 14 December 2016 03:08 PM, Pratyush Anand wrote:
>
>>
>> I would go as far as to generate the page tables at 'kexec -l' time,
>> and only if
>
> Ok..So you mean that I create a new section which will have page table
> entries mapping physicalmemory represented by remaining section, and
> then purgatory can just enable mmu with page table from that section,
> right? Seems doable. can do that.

I see a problem here. If we create  page table as a new segment then, 
how can we verify in purgatory that sha for page table is correct? We 
need page table before sha verification start,and we can not rely the 
page table created by first kernel until it's sha is verified. So a 
chicken-egg problem.

I think, creating page table will just take fraction of second and 
should be good even in purgatory, What do you say?

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

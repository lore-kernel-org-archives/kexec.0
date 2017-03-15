Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1co5S8-0003NA-5b
 for kexec@lists.infradead.org; Wed, 15 Mar 2017 09:42:46 +0000
Received: by mail-pg0-f50.google.com with SMTP id g2so6812728pge.3
 for <kexec@lists.infradead.org>; Wed, 15 Mar 2017 02:42:23 -0700 (PDT)
Subject: Re: [PATCH V2 1/2] kexec: arm64: create identity page table to be
 used in purgatory
References: <cover.1482129830.git.panand@redhat.com>
 <ea98a0045c8d466456f53150f341546810dd47e1.1482129830.git.panand@redhat.com>
 <587E53A6.6020709@arm.com> <281f2f04-842d-73d3-cd52-8774ab549c23@redhat.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <8aba46a4-411e-0a4c-0e85-ea955348f631@redhat.com>
Date: Wed, 15 Mar 2017 15:12:11 +0530
MIME-Version: 1.0
In-Reply-To: <281f2f04-842d-73d3-cd52-8774ab549c23@redhat.com>
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
Cc: geoff@infradead.org, mark.rutland@arm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi James,

On Wednesday 18 January 2017 01:13 PM, Pratyush Anand wrote:
>
>>
>>> +     * in kexec
>>> +     */
>>> +    if (next_tbl_cnt > 5)
>>> +        die("%s: No more memory for page table\n", __func__);
>>
>> die()? With a bit of juggling can't we return an error so we never try
>> to enable
>> the MMU+dcache instead?
>>
>
> OK. can do that.

It does not seem easy to do that. We will have to revert job of 
add_buffer_phys_virt() in case of failure, and it will need lot of new 
code. So, IMHO it would be better to keep die() as of now.
What do you say?

~Pratyush



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

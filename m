Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YkshE-00075g-OT
 for kexec@lists.infradead.org; Wed, 22 Apr 2015 11:20:01 +0000
Message-ID: <553783C2.3080207@redhat.com>
Date: Wed, 22 Apr 2015 16:49:30 +0530
From: Pratyush Anand <panand@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 1/6] purgatory: Fix memcmp for src address increment
References: <cover.1429201849.git.panand@redhat.com>
 <6ac5de6bcd76b7a0790c3a403fa0c629c4a4eff8.1429201849.git.panand@redhat.com>
 <1429289744.5479.6.camel@infradead.org> <20150420002527.GA17827@verge.net.au>
In-Reply-To: <20150420002527.GA17827@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>, Geoff Levand <geoff@infradead.org>
Cc: kexec@lists.infradead.org



On Monday 20 April 2015 05:55 AM, Simon Horman wrote:
> On Fri, Apr 17, 2015 at 09:55:44AM -0700, Geoff Levand wrote:
>> On Thu, 2015-04-16 at 22:17 +0530, Pratyush Anand wrote:
>>> src addresses are not being incremented, so only first byte is compared
>>> instead of first len bytes.
>>
>> So I guess this means we never really had proper error
>> checking in purgatory...  Better merge this one.
>>
>> Acked-by: Geoff Levand <geoff@infradead.org>
>
> Hi Pratyush,
>
> If you'd like me to take this plase repost it with Geoff's Ack
> and without "RFC".
>

It is already now in Geoff's tree so may be I do not resend it.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

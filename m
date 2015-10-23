Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zphkq-0000tl-L7
 for kexec@lists.infradead.org; Fri, 23 Oct 2015 19:11:57 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1445469125.30908.105.camel@infradead.org>
 <20151022031718.GB11227@dhcp-129-115.nay.redhat.com>
 <1445540240.30908.134.camel@infradead.org>
Date: Fri, 23 Oct 2015 14:02:34 -0500
In-Reply-To: <1445540240.30908.134.camel@infradead.org> (Geoff Levand's
 message of "Thu, 22 Oct 2015 11:57:20 -0700")
Message-ID: <87d1w52yt1.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: Add --lite option
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
To: Geoff Levand <geoff@infradead.org>
Cc: panand@redhat.com, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, Petitboot@lists.ozlabs.org, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

Geoff Levand <geoff@infradead.org> writes:

>> > It was reported that on some systems where purgatory is running
>> > without caches enabled the sha256 calculations would take several
>> > minutes.  For bootloaders that just load a new image and
>> > immediately jump into it the loss of the integrity check is worth
>> > the increase in boot speed.  Please consider.  
>> 
>> Pratyush reported the arm64 issue, he sent a patch to fix it with
>> enabling cache for purgatory. I think the patch can fix the problem.
>> Why not fix it? The fix is simple enough and it does not introduce
>> complicate logic.
>
> This patch also is simple, and is architecture independent.  I see this
> feature as an improvement to kexec, not necessarily as a fix for that
> problem.

Disabling image verification is not an improvement, all it does is
allow for a nasty form of heisenbug.


Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

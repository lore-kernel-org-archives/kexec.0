Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YjFfM-0007Lp-Dn
 for kexec@lists.infradead.org; Fri, 17 Apr 2015 23:27:21 +0000
Message-ID: <553196BF.4080703@redhat.com>
Date: Sat, 18 Apr 2015 04:56:55 +0530
From: Pratyush Anand <panand@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 2/6] purgatory: No need to sha256 update if ptr->len
 is zero
References: <cover.1429201849.git.panand@redhat.com>
 <a66d1e193a9bd27e940edfbb56ca521556e95b39.1429201849.git.panand@redhat.com>
 <1429289920.5479.8.camel@infradead.org>
In-Reply-To: <1429289920.5479.8.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: kexec@lists.infradead.org, kexec@lists.fedoraproject.org



On Friday 17 April 2015 10:28 PM, Geoff Levand wrote:
> On Thu, 2015-04-16 at 22:17 +0530, Pratyush Anand wrote:
>> If ptr->len is zero we do not need to update sha256.
>
> Looks OK.  Did you find this sped things up?

No.. I am working for that..

Speed is good when sha256 is prepared in update_purgatory..just a sec..
while it is 2 min during verification..

one diff is that purgatory is using byte copy in memcpy while kexec had 
generic memcpy which has byte/word/page copy features.

But, Most likely speed is low because dcache is disabled.
So I am working to enable d-cache and identity mapped mmu table for 
crashdump regions in purgatory.

~Pratyush

>
> Acked-by: Geoff Levand <geoff@infradead.org>
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

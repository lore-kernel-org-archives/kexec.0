Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fIDGn-0004Pc-0x
 for kexec@lists.infradead.org; Mon, 14 May 2018 13:12:06 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <cover.1525253481.git.rahul.lakkireddy@chelsio.com>
 <20180513.201131.1649805811466916646.davem@davemloft.net>
Date: Mon, 14 May 2018 08:11:24 -0500
In-Reply-To: <20180513.201131.1649805811466916646.davem@davemloft.net> (David
 Miller's message of "Sun, 13 May 2018 20:11:31 -0400 (EDT)")
Message-ID: <87a7t2mlfn.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v8 0/3] kernel: add support to collect hardware
 logs in crash recovery kernel
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
To: David Miller <davem@davemloft.net>
Cc: indranil@chelsio.com, netdev@vger.kernel.org, nirranjan@chelsio.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stephen@networkplumber.org, rahul.lakkireddy@chelsio.com, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, ganeshgr@chelsio.com

David Miller <davem@davemloft.net> writes:

> I'm deferring this patch series.
>
> If we can't get a reasonable review from an interested party in 10+
> days, that is not reasonable.
>
> Resubmit this once someone reviews it properly.

David I am out on vacation this week and last (the reason for the delay).

The last version of this that I looked at I gave my ack.  All of my ABI
concerns had been addressed. The only outstanding change I believe was
the Eric Dumazet's asking about something being reviewed.

I just glanced over it again and I don't see any new issues introduced
by the last round of changes.

From 10,000 feet flyover design perspectie and from an ABI perspective
this patchset seems fine.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

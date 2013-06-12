Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Umsyl-0001KQ-6I
 for kexec@lists.infradead.org; Wed, 12 Jun 2013 21:53:20 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <E1UmXSQ-0008Nq-27@eag09.americas.sgi.com>
 <87wqq0ruif.fsf@xmission.com> <20130612164000.GA16154@sgi.com>
Date: Wed, 12 Jun 2013 14:52:29 -0700
In-Reply-To: <20130612164000.GA16154@sgi.com> (Cliff Wickman's message of
 "Wed, 12 Jun 2013 11:40:00 -0500")
Message-ID: <878v2fq9nm.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: kexec: purgatory hang
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Cliff Wickman <cpw@sgi.com>
Cc: yinghai@kernel.org, kexec@lists.infradead.org

Cliff Wickman <cpw@sgi.com> writes:

> Do you recall what that switch is?  I don't see any condition in
> purgatory.c.  But the existing printf's don't give me anything.

kexec --load --console-serial --serial=<port> --serial-baud=<baud_rate> ...

Possibly
kexec --load --console-vga ...

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

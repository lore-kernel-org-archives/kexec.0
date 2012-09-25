Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TGLYb-0005dy-4m
 for kexec@lists.infradead.org; Tue, 25 Sep 2012 03:11:34 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <E1TGHkf-0006ZB-22@eag09.americas.sgi.com>
Date: Mon, 24 Sep 2012 20:11:12 -0700
In-Reply-To: <E1TGHkf-0006ZB-22@eag09.americas.sgi.com> (Cliff Wickman's
 message of "Mon, 24 Sep 2012 18:07:45 -0500")
Message-ID: <877grissof.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: 896MB address limit
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Cliff Wickman <cpw@sgi.com>
Cc: kexec@lists.infradead.org

Cliff Wickman <cpw@sgi.com> writes:

> Gentlemen,
>
> In dumping very large memories we are running up against the 896MB 
> limit in SLES11SP2 (3.0.38 kernel).

Odd.  That limit should be the maximum address in memory to load the
crash kernel.  Tha limit should have nothing to do with the dump process
itself.

Are you saying you need more that 512MiB reserved for the crash kernel
to be able to dump all of the memory in your system?

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

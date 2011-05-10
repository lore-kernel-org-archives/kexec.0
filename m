Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from adelie.canonical.com ([91.189.90.139])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QJhEa-0007uS-C6
	for kexec@lists.infradead.org; Tue, 10 May 2011 07:19:57 +0000
Message-ID: <4DC8E715.2050102@canonical.com>
Date: Tue, 10 May 2011 09:19:49 +0200
From: Bouchard Louis <louis.bouchard@canonical.com>
MIME-Version: 1.0
Subject: Re: [Bug] Kdump does not work when panic triggered due to MCE
References: <20110506165412.GB2719@in.ibm.com>	<20110509123902.GA5975@redhat.com>
	<4DC80662.9000703@canonical.com> <20110509170336.GC1963@in.ibm.com>
In-Reply-To: <20110509170336.GC1963@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: prasad@linux.vnet.ibm.com
Cc: Bouchard Louis <louis.bouchard@canonical.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

Le 09/05/2011 19:03, K.Prasad a =E9crit :
> On Mon, May 09, 2011 at 05:21:06PM +0200, Bouchard Louis wrote:
>> I have seen numerous occurrences of MCE triggered kernel panics on both
>> RHEL & SLES environment used on IA32 architecture. Both in contexts
>> where kexec/kdump was being used.
>>
> That's interesting! Assuming that these are not software induced MCEs
> but panic() calls invoked due to unrecoverable memory errors in a
> physical machine, did you experience any situation where the kdump
> kernel hung/rebooted due to a second MCE (triggered while reading the
> faulty memory location belonging to the first kernel)? =

What I'm relating is issues I have seen in the past, while I was
employed somewhere else. Unfortunately, I no longer have access to any
of those dumps.

Kind regards,

...Louis

-- =

Louis Bouchard
Server Support Analyst
Canonical Ltd
Ubuntu support: http://landscape.canonical.com


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from adelie.canonical.com ([91.189.90.139])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QJSGl-0003UC-Vm
	for kexec@lists.infradead.org; Mon, 09 May 2011 15:21:13 +0000
Message-ID: <4DC80662.9000703@canonical.com>
Date: Mon, 09 May 2011 17:21:06 +0200
From: Bouchard Louis <louis.bouchard@canonical.com>
MIME-Version: 1.0
Subject: Re: [Bug] Kdump does not work when panic triggered due to MCE
References: <20110506165412.GB2719@in.ibm.com>
	<20110509123902.GA5975@redhat.com>
In-Reply-To: <20110509123902.GA5975@redhat.com>
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: prasad@linux.vnet.ibm.com, Vivek Goyal <vgoyal@redhat.com>

Hello,

Le 09/05/2011 14:39, Vivek Goyal a =E9crit :
>
> Prasad,
>
> I have never tried taking dump in MCE situation. Does kdump work on this
> machine with normal panic()?
>
> Use --debug and --serial option in kexec-tools to print some debug message
> and look for "I am in purgatory". This will tell you whether you hanged
> in first kernel or second kernel.
>
> Then put "outb()" messages in the kernel to trace what happened. =

>
> Thanks
> Vivek
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
I have seen numerous occurrences of MCE triggered kernel panics on both
RHEL & SLES environment used on IA32 architecture. Both in contexts
where kexec/kdump was being used.

 Matter of fact, MCE triggered panic are part of the reason that pushed
me to work on crashdc : only one crash command is required to get the
MCE trace out of the kernel ring buffer. This avoids transfering massive
amount of vmcore file over the net.

crashdc does well on those, mcelog can be applied on the data gathered.

HTH,

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

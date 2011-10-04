Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]
	helo=DB3EHSOBE002.bigfish.com)
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RAwen-0001Ft-GB
	for kexec@lists.infradead.org; Tue, 04 Oct 2011 04:31:06 +0000
From: McClintock Matthew-B29882 <B29882@freescale.com>
Subject: Re: [PATCH] kexec: powerpc: crash_dump: No backup region for PPC BookE
Date: Tue, 4 Oct 2011 04:30:36 +0000
Message-ID: <CAEsOVNf8EtKF4u2QgMdmQYhCh4f=W8M-=bjbNM_i1O1=hkFDDA@mail.gmail.com>
References: <20111003101746.30979.44424.stgit@suzukikp.in.ibm.com>
	<CAEsOVNefdrEgkSG9gO13kQW2akjYWX=Q6xEEkwxQ4Vv5ndfGKw@mail.gmail.com>
	<4E8A7BAF.9020908@in.ibm.com> <4E8A7CF9.9020009@in.ibm.com>
In-Reply-To: <4E8A7CF9.9020009@in.ibm.com>
Content-Language: en-US
Content-ID: <481B69AC46E1EE45904AC3B37EBC975B@freescale.net>
MIME-Version: 1.0
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Suzuki Poulose <suzuki@in.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Simon Horman <horms@verge.net.au>, Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "M. Mohan Kumar" <mohan@in.ibm.com>, McClintock Matthew-B29882 <B29882@freescale.com>, Vivek Goyal <vgoyal@redhat.com>

On Mon, Oct 3, 2011 at 10:26 PM, Suzuki Poulose <suzuki@in.ibm.com> wrote:
>>> So there were two crash regions when we only needed the one specified
>>> on the command line?
>>>
>> Yes, and isn't that is expected ? The first kernel uses the memory region
>> (0-100M), (228M,256M). Where the 100-228M is reserved for crash kernel.
>
> The CRASH MEMORY RANGES denotes the memory ranges of the crashed kernel and
> usable memory regions denote the memory usable by the second kernel.

Right I agree, I don't remember there being two when I was looking at
this. Looks fine to me, but I have not looked at kexec on BookE in a
while.

-M

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

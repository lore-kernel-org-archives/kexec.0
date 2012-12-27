Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1To8IB-00075I-GQ
 for kexec@lists.infradead.org; Thu, 27 Dec 2012 07:54:16 +0000
In-Reply-To: <50DBC856.6030208@zytor.com>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
 <50DBC856.6030208@zytor.com>
MIME-Version: 1.0
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 26 Dec 2012 23:53:49 -0800
Message-ID: <791b4922-078f-4adc-b3f3-0651f2266147@email.android.com>
Subject: Re: [PATCH v3 00/11] xen: Initial kexec/kdump implementation
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
To: "H. Peter Anvin" <hpa@zytor.com>, Daniel Kiper <daniel.kiper@oracle.com>
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, jbeulich@suse.com, maxim.uvarov@oracle.com, tglx@linutronix.de, vgoyal@redhat.com

The syscall ABI still has the wrong semantics.

Aka totally unmaintainable and umergeable.

The concept of domU support is also strange.  What does domU support even mean, when the dom0 support is loading a kernel to pick up Xen when Xen falls over.

I expect a lot of decisions about what code can be shared and what code can't is going to be driven by the simple question what does the syscall mean.

Sharing machine_kexec.c and relocate_kernel.S does not make much sense to me when what you are doing is effectively passing your arguments through to the Xen version of kexec.

Either Xen has it's own version of those routines or I expect the Xen version of kexec is buggy.   I can't imagine what sharing that code would mean.  By the same token I can't any need to duplicate the code either.

Furthermore since this is just passing data from one version of the syscall to another I expect you can share the majority of the code across all architectures that implement Xen.  The only part I can see being arch specific is the Xen syscall stub.

With respect to the proposed semantics of silently giving the kexec system call different meaning when running under Xen,
/sbin/kexec has to act somewhat differently when loading code into the Xen hypervisor so there is no point not making that explicit in the ABI.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.eu.citrix.com ([46.33.159.39])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TbiV3-0005zy-CD
 for kexec@lists.infradead.org; Fri, 23 Nov 2012 01:56:14 +0000
Message-ID: <50AED7B8.7040902@citrix.com>
Date: Fri, 23 Nov 2012 01:56:08 +0000
From: Andrew Cooper <andrew.cooper3@citrix.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 01/11] kexec: introduce kexec_ops struct
References: <1353423893-23125-1-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-2-git-send-email-daniel.kiper@oracle.com>
 <87lidwtego.fsf@xmission.com>
 <20121121105221.GA2925@host-192-168-1-59.local.net-space.pl>
 <87txshx28b.fsf@xmission.com> <50AE6542.3020302@zytor.com>
 <50AEBF86.50501@citrix.com>
 <18e831d4-910d-4f58-8911-1398b96e3a47@email.android.com>
In-Reply-To: <18e831d4-910d-4f58-8911-1398b96e3a47@email.android.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, Daniel Kiper <daniel.kiper@oracle.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "jbeulich@suse.com" <jbeulich@suse.com>, "tglx@linutronix.de" <tglx@linutronix.de>

On 23/11/2012 01:38, H. Peter Anvin wrote:
> I still don't really get why it can't be isolated from dom0, which would make more sense to me, even for a Xen crash.
>

The crash region (as specified by crashkernel= on the Xen command line)
is isolated from dom0.

dom0 (using the kexec utility etc) has the task of locating the Xen
crash notes (using the kexec hypercall interface), constructing a binary
blob containing kernel, initram and gubbins, and asking Xen to put this
blob in the crash region (again, using the kexec hypercall interface).

I do not see how this is very much different from the native case
currently (although please correct me if I am misinformed).  Linux has
extra work to do by populating /proc/iomem with the Xen crash regions
boot (so the kexec utility can reference their physical addresses when
constructing the blob), and should just act as a conduit between the
kexec system call and the kexec hypercall to load the blob.

For within-guest kexec/kdump functionality, I agree that it is barking
mad.  However, we do see cloud operators interested in the idea so VM
administrators can look after their crashes themselves.

~Andrew

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

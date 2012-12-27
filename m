Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1To5My-00089A-OL
 for kexec@lists.infradead.org; Thu, 27 Dec 2012 04:47:01 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-2-git-send-email-daniel.kiper@oracle.com>
Date: Wed, 26 Dec 2012 20:46:27 -0800
In-Reply-To: <1356574740-6806-2-git-send-email-daniel.kiper@oracle.com>
 (Daniel Kiper's message of "Thu, 27 Dec 2012 03:18:50 +0100")
Message-ID: <878v8k14rg.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 01/11] kexec: introduce kexec firmware support
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: x86@kernel.org, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, hpa@zytor.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, jbeulich@suse.com, maxim.uvarov@oracle.com, tglx@linutronix.de, xen-devel@lists.xensource.com, vgoyal@redhat.com

Daniel Kiper <daniel.kiper@oracle.com> writes:

> Some kexec/kdump implementations (e.g. Xen PVOPS) could not use default
> Linux infrastructure and require some support from firmware and/or hypervisor.
> To cope with that problem kexec firmware infrastructure was introduced.
> It allows a developer to use all kexec/kdump features of given firmware
> or hypervisor.

As this stands this patch is wrong.

You need to pass an additional flag from userspace through /sbin/kexec
that says load the kexec image in the firmware.  A global variable here
is not ok.

As I understand it you are loading a kexec on xen panic image.  Which
is semantically different from a kexec on linux panic image.  It is not
ok to do have a silly global variable kexec_use_firmware.

Furthermore it is not ok to have a conditional code outside of header
files.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

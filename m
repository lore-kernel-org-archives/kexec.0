Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nat28.tlf.novell.com ([130.57.49.28])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Ts9Jk-0001aD-UP
 for kexec@lists.infradead.org; Mon, 07 Jan 2013 09:48:29 +0000
Message-Id: <50EAA7F402000078000B34C3@nat28.tlf.novell.com>
Date: Mon, 07 Jan 2013 09:48:20 +0000
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [PATCH v3 02/11] x86/kexec: Add extra pointers to
 transition page table PGD, PUD, PMD and PTE
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-2-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-3-git-send-email-daniel.kiper@oracle.com>
 <50E55ECF02000078000B2A13@nat28.tlf.novell.com>
 <20130104151542.GD3346@host-192-168-1-59.local.net-space.pl>
 <50E70D8002000078000B336D@nat28.tlf.novell.com>
 <20130104172538.GC3472@host-192-168-1-59.local.net-space.pl>
In-Reply-To: <20130104172538.GC3472@host-192-168-1-59.local.net-space.pl>
Mime-Version: 1.0
Content-Disposition: inline
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
Cc: hpa@zytor.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel <xen-devel@lists.xen.org>, mingo@redhat.com, ebiederm@xmission.com, maxim.uvarov@oracle.com, tglx@linutronix.de, virtualization@lists.linux-foundation.org, vgoyal@redhat.com

>>> On 04.01.13 at 18:25, Daniel Kiper <daniel.kiper@oracle.com> wrote:
> Right, so where is virtual mapping of control page established?
> I could not find relevant code in SLES kernel which does that.

In the hypervisor (xen/arch/x86/machine_kexec.c:machine_kexec_load()).
xen/arch/x86/machine_kexec.c:machine_kexec() then simply uses
image->page_list[1].

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

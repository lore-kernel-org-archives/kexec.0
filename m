Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RpLfe-0001io-QA
 for kexec@lists.infradead.org; Mon, 23 Jan 2012 15:19:00 +0000
Date: Mon, 23 Jan 2012 10:18:54 -0500
From: Don Zickus <dzickus@redhat.com>
Subject: Re: kdump not working Intel S5520UR motherboards with Xeon processor
Message-ID: <20120123151854.GL5650@redhat.com>
References: <20111027203029.GR3452@redhat.com> <4EA9D09E.800@draigBrady.com>
 <7967B71B602AF546971AB6303361B1A561AC86E1E8@mbe.inside.abhaisystems.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7967B71B602AF546971AB6303361B1A561AC86E1E8@mbe.inside.abhaisystems.com>
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
To: Prashant Dinkar Kharche <pkharche@inmage.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Sat, Jan 21, 2012 at 10:21:17AM -0800, Prashant Dinkar Kharche wrote:
> Hi,
> 
> I have been trying to get kdump working on Intel S5520 chipset with Xeon processor on RHEL 5 update 5  or update 6, but it appears that when I trigger a crash dump, system reboots abruptly right after loading the kdump kernel. Key observation during this experiment was that when I turn off acpi interrupt handling (acpi=off), crash has worked on RHEL 5 update 5. I have captured output of lspci and cpuinfo  below for reference.
> 
> Whereas, on RHEL 6 kdump works fine on this hardware. Could someone please help me identify the patches for RHEL 5 update 5 kernel that might be required for this issue?

This can only be done by Red Hat as they are the only ones that know what
patches are in their kernel.  Please file a bugzilla or work with your TAM
to bring attention to the problem at Red Hat.

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

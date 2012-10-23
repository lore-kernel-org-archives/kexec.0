Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from qmta01.emeryville.ca.mail.comcast.net
 ([2001:558:fe2d:43:76:96:30:16])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TQebk-0006Iw-4j
 for kexec@lists.infradead.org; Tue, 23 Oct 2012 13:33:24 +0000
Message-ID: <1350999198.30243.43.camel@rhapsody>
Subject: Re: [PATCH v2] kdump: pass acpi_rsdp= to 2nd kernel for efi booting
From: Khalid Aziz <khalid@gonehiking.org>
Date: Tue, 23 Oct 2012 07:33:18 -0600
In-Reply-To: <20121022154300.GD3401@redhat.com>
References: <20121018031608.GA3925@localhost.localdomain>
 <878vb332a9.fsf@xmission.com> <20121019145300.GC27052@redhat.com>
 <874nlole1c.fsf@xmission.com> <20121022154300.GD3401@redhat.com>
Mime-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, horms@verge.net.au, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>

On Mon, 2012-10-22 at 11:43 -0400, Vivek Goyal wrote:
> On Sat, Oct 20, 2012 at 08:06:23PM -0700, Eric W. Biederman wrote:
> 
> [..]
> > It is the non-pure UEFI case where non-UEFI table scans work.
> > 
> > Of course it puzzles me why we can't find the table via scanning memory
> > when running in a pure UEFI environment.  Ah well that is a problem for
> > another day.
> 
> I have the same question. Why can we find acpi tables by scaning in
> non-uefi case and why same is not possible in case of UEFI.

I had sent an explanation out on Friday but looks like my email got
stuck somewhere, and I don't see it on kexec list archive.

On a UEFI machine with CSM, kernel finds RSDP by searching through EBDA.
On a UEFI machine with no CSM, there is no EBDA I believe and kernel
fails to find RSDP. Here is the message I see on a UEFI machine with no
CSM:

ACPI BIOS Bug: Error: A valid RSDP was not found (20120913/tbxfroot-219)


--
Khalid




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TQK9h-0002aA-H9
 for kexec@lists.infradead.org; Mon, 22 Oct 2012 15:43:06 +0000
Date: Mon, 22 Oct 2012 11:43:00 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2] kdump: pass acpi_rsdp= to 2nd kernel for efi booting
Message-ID: <20121022154300.GD3401@redhat.com>
References: <20121018031608.GA3925@localhost.localdomain>
 <878vb332a9.fsf@xmission.com> <20121019145300.GC27052@redhat.com>
 <874nlole1c.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <874nlole1c.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, Dave Young <dyoung@redhat.com>, khalid@gonehiking.org

On Sat, Oct 20, 2012 at 08:06:23PM -0700, Eric W. Biederman wrote:

[..]
> It is the non-pure UEFI case where non-UEFI table scans work.
> 
> Of course it puzzles me why we can't find the table via scanning memory
> when running in a pure UEFI environment.  Ah well that is a problem for
> another day.

I have the same question. Why can we find acpi tables by scaning in
non-uefi case and why same is not possible in case of UEFI.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

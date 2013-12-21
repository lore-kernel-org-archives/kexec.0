Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VuDJ0-0005WG-5u
 for kexec@lists.infradead.org; Sat, 21 Dec 2013 03:32:47 +0000
Message-ID: <52B50BBB.9070806@zytor.com>
Date: Fri, 20 Dec 2013 19:32:11 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 4/6] kexec: A new system call, kexec_file_load, for in
 kernel kexec
References: <20131121190350.GC17070@kroah.com>	<20131121190620.GA25951@srcf.ucam.org>	<20131121191305.GK16208@redhat.com>	<20131121191907.GA26366@srcf.ucam.org>	<20131122185706.GK4046@redhat.com>
 <87vbzju6ql.fsf@xmission.com>	<20131125163920.GC23094@redhat.com>
 <87fvqj2vxz.fsf@xmission.com>	<20131126142759.GA5473@redhat.com>
 <20131219125439.GA6379@lst.de>	<20131220141917.GB27063@redhat.com>
 <87a9fvqfs4.fsf@xmission.com>	<52B4D0C6.2000505@zytor.com>
 <87ioujf0ox.fsf@xmission.com>
In-Reply-To: <87ioujf0ox.fsf@xmission.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Kees Cook <keescook@chromium.org>, Greg KH <greg@kroah.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>, Torsten Duwe <duwe@lst.de>, Vivek Goyal <vgoyal@redhat.com>

On 12/20/2013 05:32 PM, Eric W. Biederman wrote:
> 
> Stuff and nonsense.  bzImage is just an ugly wrapper around an ELF
> image.
> 

Not really.  We put the ELF image in there to help Xen and presumably
kexec, but there are actually quite a few issues with it... for one
thing, as currently built there are megabytes of zeroes in it for no
good reason.

Even if you don't need the entry code, the additional metadata is
meaningful.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

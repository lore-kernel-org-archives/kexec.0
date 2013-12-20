Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vu9Ng-0002jt-Vc
 for kexec@lists.infradead.org; Fri, 20 Dec 2013 23:21:21 +0000
Message-ID: <52B4D0C6.2000505@zytor.com>
Date: Fri, 20 Dec 2013 15:20:38 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 4/6] kexec: A new system call, kexec_file_load, for in
 kernel kexec
References: <20131121190350.GC17070@kroah.com>	<20131121190620.GA25951@srcf.ucam.org>	<20131121191305.GK16208@redhat.com>	<20131121191907.GA26366@srcf.ucam.org>	<20131122185706.GK4046@redhat.com>
 <87vbzju6ql.fsf@xmission.com>	<20131125163920.GC23094@redhat.com>
 <87fvqj2vxz.fsf@xmission.com>	<20131126142759.GA5473@redhat.com>
 <20131219125439.GA6379@lst.de>	<20131220141917.GB27063@redhat.com>
 <87a9fvqfs4.fsf@xmission.com>
In-Reply-To: <87a9fvqfs4.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Kees Cook <keescook@chromium.org>, Greg KH <greg@kroah.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>, Torsten Duwe <duwe@lst.de>

On 12/20/2013 03:11 PM, Eric W. Biederman wrote:
> 
> In that case the chrome folks would simply have to use an ELF format
> kernel and not a bzImage.
> 

This is starting to feel like everything is going in the direction of a
massive feature regression.  bzImage may be weird (it has definitely
grown organically), but the features that have been added to it have
generally been for a reason, e.g. kernel relocation and so on.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

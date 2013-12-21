Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VuKtj-0001SC-6h
 for kexec@lists.infradead.org; Sat, 21 Dec 2013 11:39:12 +0000
Date: Sat, 21 Dec 2013 12:38:45 +0100
From: Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH 4/6] kexec: A new system call, kexec_file_load, for in
 kernel kexec
Message-ID: <20131221113845.GA9002@lst.de>
References: <20131121191907.GA26366@srcf.ucam.org>
 <20131122185706.GK4046@redhat.com> <87vbzju6ql.fsf@xmission.com>
 <20131125163920.GC23094@redhat.com> <87fvqj2vxz.fsf@xmission.com>
 <20131126142759.GA5473@redhat.com> <20131219125439.GA6379@lst.de>
 <20131220141917.GB27063@redhat.com> <87a9fvqfs4.fsf@xmission.com>
 <CAGXu5jKJ88J-++nvkPVvghkXbN+_mB=T1siSDF7yoXQ-d-ONxg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGXu5jKJ88J-++nvkPVvghkXbN+_mB=T1siSDF7yoXQ-d-ONxg@mail.gmail.com>
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
To: Kees Cook <keescook@chromium.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Greg KH <greg@kroah.com>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Peter Jones <pjones@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>

On Fri, Dec 20, 2013 at 03:20:16PM -0800, Kees Cook wrote:
> 
> If we're doing fd origin verification (not signatures), can't we
> continue to use a regular bzImage?

I imagine the verification function is separated from the new kexec.
It gets passed the proposed new kernel file*, an optional signature
file*, and maybe hints about the kernel format and system security state.

With that function, you can do whatever you want. If you want to take
an early positive exit due to the location of the new kernel, you're fine.

	Torsten


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

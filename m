Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fOsoY-0001Xe-Ru
 for kexec@lists.infradead.org; Fri, 01 Jun 2018 22:46:32 +0000
Date: Sat, 2 Jun 2018 00:46:17 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v4 5/8] ima: based on policy require signed firmware
 (sysfs fallback)
Message-ID: <20180601224617.GU4511@wotan.suse.de>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527616920-5415-6-git-send-email-zohar@linux.vnet.ibm.com>
 <20180601182107.GO4511@wotan.suse.de>
 <1527892795.13403.26.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1527892795.13403.26.camel@linux.vnet.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, "Luis R. Rodriguez" <mcgrof@kernel.org>, Matthew Garrett <mjg59@google.com>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, linux-integrity@vger.kernel.org, Andres Rodriguez <andresx7@gmail.com>

On Fri, Jun 01, 2018 at 06:39:55PM -0400, Mimi Zohar wrote:
> On Fri, 2018-06-01 at 20:21 +0200, Luis R. Rodriguez wrote:
> > On Tue, May 29, 2018 at 02:01:57PM -0400, Mimi Zohar wrote:
> > > Luis, is the security_kernel_post_read_file LSM hook in
> > > firmware_loading_store() still needed after this patch?  Should it be
> > > calling security_kernel_load_data() instead?
> > =

> > That's up to Kees to decide as he added that hook, and knows
> > what LSMs may be doing with it. From my perspective it is confusing
> > to have that hook there so I think it could be removed now.
> > =

> > Kees?
> =

> Commit=A06593d92 ("firmware_class: perform new LSM checks") references
> two methods of loading firmware -=A0=A0filesystem-found firmware and
> demand-loaded blobs. =A0I assume this call in firmware_loading_store()
> is the demand-loaded blobs. =A0Does that method still exist? =A0Is it
> still being used?

Yeah its the stupid sysfs interface. So likely loadpin needs porting
as you IMA as you did.

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m9jGm-00B9Xc-75
 for kexec@lists.infradead.org; Sat, 31 Jul 2021 07:18:53 +0000
Date: Sat, 31 Jul 2021 09:18:48 +0200
From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 04/12] x86/sev: Do not hardcode GHCB protocol version
Message-ID: <YQT5WPANjqXSytPR@suse.de>
References: <20210721142015.1401-1-joro@8bytes.org>
 <20210721142015.1401-5-joro@8bytes.org>
 <1eef6235-a8d0-1012-969e-ef6f0804d054@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1eef6235-a8d0-1012-969e-ef6f0804d054@amd.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>, Martin Radev <martin.b.radev@gmail.com>, Arvind Sankar <nivedita@alum.mit.edu>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org

Hi Tom,

On Wed, Jul 21, 2021 at 04:17:38PM -0500, Tom Lendacky wrote:
> On 7/21/21 9:20 AM, Joerg Roedel wrote:
> >  	/* Fill in protocol and format specifiers */
> > -	ghcb->protocol_version = GHCB_PROTOCOL_MAX;
> > +	ghcb->protocol_version = sev_get_ghcb_proto_ver();
> 
> So this probably needs better clarification in the spec, but the GHCB
> version field is for the GHCB structure layout. So if you don't plan to
> use the XSS field that was added for version 2 of the layout, then you
> should report the GHCB structure version as 1.

Yeah, this makes sense, exept for the struct field-name ;) But anyway, I
keep the version field at 1 for now.

Regards,

	Joerg

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

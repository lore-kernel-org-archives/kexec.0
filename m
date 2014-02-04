Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WAiik-00076z-MS
 for kexec@lists.infradead.org; Tue, 04 Feb 2014 16:19:36 +0000
Date: Tue, 4 Feb 2014 11:19:08 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Next kexec release
Message-ID: <20140204161908.GB8373@redhat.com>
References: <CAB=NE6WzCjtsq0hCUt=H62V7y2wd3dTeE-q0=R282kdobbXjcA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAB=NE6WzCjtsq0hCUt=H62V7y2wd3dTeE-q0=R282kdobbXjcA@mail.gmail.com>
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
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: Tony Jones <tonyj@suse.com>, Olaf Hering <ohering@suse.de>, kexec@lists.infradead.org, Jan Beulich <JBeulich@suse.com>

On Mon, Feb 03, 2014 at 07:49:11PM -0800, Luis R. Rodriguez wrote:
> Hey folks, I see recent discussions about desire for a new recent
> release of kexec, one of such reasons is kexec support on EFI systems.
> SUSE is also interested in this, and it'd be great if we can all synch
> up on supporting the same recent release.
> 

Hi Luis,

I wanted to make sure that there are more frequent releases of kexec-tools
so that every release of Fedora, we can rebase to new kexec-tools and
support that. 

I think this should should to Suse and other distributions. More frequent
releases will allow more frequent rebases to newer versions and allow
users to test newer kexec-tools easily.

Thanks to Simon that he has agreed to release kexec-tools every alternate
kernel release (roughly every 6 months).

W.r.t syncing on supporting same kexec-tools release, I am not sure how
will that work. Every distribution will have its own release schedule.
And most likely they will rebease to newer version when window for
next release opens so that it can get maximum testing time.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UxijT-00067S-U1
 for kexec@lists.infradead.org; Fri, 12 Jul 2013 19:10:20 +0000
Date: Fri, 12 Jul 2013 21:09:36 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [Xen-devel] [PATCH 2/7] elf: Increase buf size in
 get_pt_note_info()
Message-ID: <20130712190936.GA16948@debian70-amd64.local.net-space.pl>
References: <1373636895-31682-1-git-send-email-daniel.kiper@oracle.com>
 <1373636895-31682-3-git-send-email-daniel.kiper@oracle.com>
 <51E00CF9.7080604@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51E00CF9.7080604@citrix.com>
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
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: kexec@lists.infradead.org, xen-devel@lists.xensource.com, kumagai-atsushi@mxc.nes.nec.co.jp

On Fri, Jul 12, 2013 at 03:04:41PM +0100, Andrew Cooper wrote:
> On 12/07/13 14:48, Daniel Kiper wrote:
> > get_pt_note_info() always ignores VMCOREINFO_XEN note
> > because buf size is too small. It does not have place
> > for \0 char which marks EOS. This patch fixes that bug
> > and VMCOREINFO_XEN note living in /proc/vmcore file
> > could be properly detected now.
> >
> > Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> > ---
> >  elf_info.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/elf_info.c b/elf_info.c
> > index 0c1e36a..70a6dd2 100644
> > --- a/elf_info.c
> > +++ b/elf_info.c
> > @@ -310,7 +310,7 @@ get_pt_note_info(void)
> >  {
> >  	int n_type, size_name, size_desc;
> >  	off_t offset, offset_desc;
> > -	char buf[VMCOREINFO_XEN_NOTE_NAME_BYTES];
> > +	char buf[VMCOREINFO_XEN_NOTE_NAME_BYTES + 1];
> >  	char note[MAX_SIZE_NHDR];
> >
> >  	nr_cpus = 0;
>
> Elf Note namesz is defined to include the terminating null character, so
> I would argue that VMCOREINFO_XEN_NOTE_NAME_BYTES is off-by-one.

I have checked that once again. By mistake I have assumed that
sizeof("string") does not take into account \0 char (like strlen()).
It means that in real buf could accommodate VMCOREINFO_XEN string
with EOS and relevant condition should be fixed instead of buf size.
I will fix it in second patch series release.

Thanks,

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

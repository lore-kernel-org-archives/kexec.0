From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 26 May 2022 21:01:14 -0400
Subject: [PATCH] kexec_file: Increase maximum file size to 4G
In-Reply-To: <CA+CK2bDkKzp6uvy+f09K=COd3xn+EDa5nEu2j2o7Vyhd=aG0AA@mail.gmail.com>
References: <20220526203805.3659597-1-tatashin@google.com> <CA+CK2bDkKzp6uvy+f09K=COd3xn+EDa5nEu2j2o7Vyhd=aG0AA@mail.gmail.com>
Message-ID: <CA+CK2bAKiJzMB_=TFKa=KC0pKaT2N3qgHnKSnZCU99hB=e+_LA@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu, May 26, 2022 at 4:45 PM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Thu, May 26, 2022 at 4:38 PM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > In some case initrd can be large. For example, it could be a netboot
> > image loaded by u-root, that is kexec'ing into it.
> >
> > The maximum size of initrd is arbitrary set to 2G. Also, the limit is
> > not very obvious because it is hidden behind a generic INT_MAX macro.
> >
> > Theoretically, we could make it LONG_MAX, but it is safer to keep it
> > sane, and just increase it to 4G.
> >
> > Increase the size to 4G, and make it obvious by having a new macro
> > that specifies the maximum file size supported by kexec_file_load()
> > syscall: KEXEC_FILE_SIZE_MAX.

It appears that since:
f7a4f689bca6072492626938aad6dd2f32c5bf97
fs/kernel_read_file: Remove redundant size argument

Introduced a change to  kernel_read_file to limit the maximum file
internally from SIZE_MAX to INT_MAX.

Therefore, more changes will be needed. I will work on them and sent them in v2.


> >
> > Signed-off-by: Pasha Tatashin <tatashin@google.com>
>
> Should be instead:
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> Thanks,
> Pasha
>
> > ---
> >  kernel/kexec_file.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 8347fc158d2b..1be2227b33e6 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -31,6 +31,9 @@
> >
> >  static int kexec_calculate_store_digests(struct kimage *image);
> >
> > +/* Maximum size in bytes for kernel/initrd files. */
> > +#define KEXEC_FILE_SIZE_MAX    (4UL << 30)

Also, I will address 32-bit, with picking minimum between SIZE_MAX and
kexec max file.

Thanks,
Pasha


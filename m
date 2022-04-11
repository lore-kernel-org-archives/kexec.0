From: Michal =?unknown-8bit?q?Such=C3=A1nek?= <msuchanek@suse.de>
Date: Mon, 11 Apr 2022 10:43:06 +0200
Subject: [PATCH v5 0/3] use more system keyrings to verify arm64 kdump
 kernel image signature
In-Reply-To: <20220411015218.ckw42xx5rrhidhpd@Rk>
References: <20220401013118.348084-1-coxu@redhat.com>
 <Yk/hf7JEgALZOqE8@MiWiFi-R3L-srv>
 <20220408085931.GW163591@kunlun.suse.cz>
 <YlOAvM4qpSlHczOd@MiWiFi-R3L-srv>
 <20220411015218.ckw42xx5rrhidhpd@Rk>
Message-ID: <20220411084306.GY163591@kunlun.suse.cz>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, Apr 11, 2022 at 09:52:18AM +0800, Coiby Xu wrote:
> On Mon, Apr 11, 2022 at 09:13:32AM +0800, Baoquan He wrote:
> > On 04/08/22 at 10:59am, Michal Such?nek wrote:
> > > On Fri, Apr 08, 2022 at 03:17:19PM +0800, Baoquan He wrote:
> > > > Hi Coiby,
> > > >
> > > > On 04/01/22 at 09:31am, Coiby Xu wrote:
> > > > > Currently, a problem faced by arm64 is if a kernel image is signed by a
> > > > > MOK key, loading it via the kexec_file_load() system call would be
> > > > > rejected with the error "Lockdown: kexec: kexec of unsigned images is
> > > > > restricted; see man kernel_lockdown.7".
> > > > >
> > > > > This patch set allows arm64 to use more system keyrings to verify kdump
> > > > > kernel image signature by making the existing code in x64 public.
> > > >
> > > > Thanks for updating. It would be great to tell why the problem is
> > > > met, then allow arm64 to use more system keyrings can solve it.
> > > 
> > > The reason is that MOK keys are (if anywhere) linked to the secondary
>                                                                ^^^^^^^^^
>                                                                platform?
> > > keyring, and only primary keyring is used on arm64.
> 
> Thanks Michal for providing the info! Btw, I think you made a typo
> because MOK keys are linked to the platform keyring, right?

No, I mean secondary, through this patchset:
https://lore.kernel.org/lkml/YhKP12KEmyqyS8rj at iki.fi/

Apparently support for importing the MOK keys into the platform keyring
also exists but I am not sure if this is upstream or downstream feature.

At any rate the MOK keys are not included in the primary keyring which
is the only keyring currently in use for kexec on arm64.

Thanks

Michal


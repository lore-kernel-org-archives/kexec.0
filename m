From: Baoquan He <bhe@redhat.com>
Date: Mon, 11 Apr 2022 09:13:32 +0800
Subject: [PATCH v5 0/3] use more system keyrings to verify arm64 kdump
 kernel image signature
In-Reply-To: <20220408085931.GW163591@kunlun.suse.cz>
References: <20220401013118.348084-1-coxu@redhat.com>
 <Yk/hf7JEgALZOqE8@MiWiFi-R3L-srv>
 <20220408085931.GW163591@kunlun.suse.cz>
Message-ID: <YlOAvM4qpSlHczOd@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 04/08/22 at 10:59am, Michal Such?nek wrote:
> On Fri, Apr 08, 2022 at 03:17:19PM +0800, Baoquan He wrote:
> > Hi Coiby,
> > 
> > On 04/01/22 at 09:31am, Coiby Xu wrote:
> > > Currently, a problem faced by arm64 is if a kernel image is signed by a
> > > MOK key, loading it via the kexec_file_load() system call would be
> > > rejected with the error "Lockdown: kexec: kexec of unsigned images is
> > > restricted; see man kernel_lockdown.7".
> > > 
> > > This patch set allows arm64 to use more system keyrings to verify kdump 
> > > kernel image signature by making the existing code in x64 public.
> > 
> > Thanks for updating. It would be great to tell why the problem is
> > met, then allow arm64 to use more system keyrings can solve it.
> 
> The reason is that MOK keys are (if anywhere) linked to the secondary
> keyring, and only primary keyring is used on arm64.

Thanks for explaining. This is valuable information and should
be put into log for better understanding when reviewing or
reading code later.



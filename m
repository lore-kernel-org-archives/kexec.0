From: Baoquan He <bhe@redhat.com>
Date: Mon, 21 Mar 2022 16:35:08 +0800
Subject: [PATCH v4 0/3] use more system keyrings to verify arm64 kdump
 kernel image signature
In-Reply-To: <20220321082807.eq7g3qgkbtdw6sre@Rk>
References: <20220318094101.274950-1-coxu@redhat.com>
 <Yjf+GwHNHxuUvFrf@MiWiFi-R3L-srv>
 <20220321082807.eq7g3qgkbtdw6sre@Rk>
Message-ID: <Yjg4vGYnN2kpSDK8@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 03/21/22 at 04:28pm, Coiby Xu wrote:
> Hi Baoquan,
> 
> On Mon, Mar 21, 2022 at 12:24:59PM +0800, Baoquan He wrote:
> > Hi Coiby,
> > 
> > On 03/18/22 at 05:40pm, Coiby Xu wrote:
> > > This patch set allows arm64 to use more system keyrings to verify kdump
> > > kernel image signature by making the existing code in x64 public.
> > 
> > Could you tell more about why arm64 need use more system keyrings to
> > verify kdump kernel iamge signature?
> > 
> > What problem have you encountered to make you want to do this?
> 
> Thanks for raising this question! Currently, a problem faced by arm64 is
> if a kernel image is signed by a MOK key, this kernel image would be
> rejected with the error "Lockdown: kexec: kexec of unsigned images is
> restricted; see man kernel_lockdown.7". I'll improve the cover letter
> and the 3rd commit message to have this info.

Thanks for the effort, Coiby.

Usually, when we post patch to solve issues, or improve, we had better
tell

1) what problem we encounter;
2) why the problem happened, what is the root cause after investigation and analysis;
3) how you fix it;

The 1) and 2) are very important to help reviewer understand what's
going on, and why this patch is needed. As you can see, in this
patchset, only 3) is presented.

Cheers



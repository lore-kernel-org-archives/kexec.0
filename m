From: Luis Chamberlain <mcgrof@kernel.org>
Date: Sat, 26 Feb 2022 12:20:44 -0800
Subject: [PATCH sysctl-next] kernel/kexec_core: move kexec_core sysctls
 into its own file
In-Reply-To: <Yhbu6UxoYXFtDyFk@fedora>
References: <20220223030318.213093-1-yingelin@huawei.com>
 <YhXwkTCwt3a4Dn9T@MiWiFi-R3L-srv>
 <c60419f8-422b-660d-8254-291182a06cbe@huawei.com>
 <Yhbu6UxoYXFtDyFk@fedora>
Message-ID: <YhqLnIjopfoBEBcV@bombadil.infradead.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu, Feb 24, 2022 at 10:35:21AM +0800, Baoquan He wrote:
> That seems to be an issue everything related to sysctl are all added to
> kernel/sysctl.c. Do you have a pointer that someone complained about it
> and people agree to scatter them into their own component code?

https://lkml.kernel.org/r/20220226031054.47DF8C340E7 at smtp.kernel.org

> I understand your concern now, I am personally not confused by that
> maybe because I haven't got stuff adding or changing into sysctls. My
> concern is if we only care and move kexec knob, or we have plan to try
> to move all of them. If there's some background information or
> discussion with a link, that would be helpful.

We're moving them all out. Sorry, yingelin's commit log message sucks
and it needs to be fixed to account for the justification. All the
filesystem sysctls are already moved out. Slowly we are moving the other
ones out and also doing minor optimizations along the way.

  Luis


From: Baoquan He <bhe@redhat.com>
Date: Mon, 21 Mar 2022 12:24:59 +0800
Subject: [PATCH v4 0/3] use more system keyrings to verify arm64 kdump
 kernel image signature
In-Reply-To: <20220318094101.274950-1-coxu@redhat.com>
References: <20220318094101.274950-1-coxu@redhat.com>
Message-ID: <Yjf+GwHNHxuUvFrf@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Coiby,

On 03/18/22 at 05:40pm, Coiby Xu wrote:
> This patch set allows arm64 to use more system keyrings to verify kdump 
> kernel image signature by making the existing code in x64 public.

Could you tell more about why arm64 need use more system keyrings to
verify kdump kernel iamge signature?

What problem have you encountered to make you want to do this?

Thanks
Baoquan



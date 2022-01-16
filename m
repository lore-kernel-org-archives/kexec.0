From: Baoquan He <bhe@redhat.com>
Date: Sun, 16 Jan 2022 21:38:47 +0800
Subject: [PATCH v2 0/5] kexec: use IS_ENABLED(CONFIG_KEXEC_CORE) instead
 of #ifdef
In-Reply-To: <20211206160514.2000-1-jszhang@kernel.org>
References: <20211206160514.2000-1-jszhang@kernel.org>
Message-ID: <20220116133847.GE2388@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Jisheng,

On 12/07/21 at 12:05am, Jisheng Zhang wrote:
> Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
> by a check for "IS_ENABLED(CONFIG_KEXEC_CORE)", to simplify the code
> and increase compile coverage.

I go through this patchset, You mention the benefits it brings are
1) simplity the code;
2) increase compile coverage;

For benefit 1), it mainly removes the dummy function in x86, arm and
arm64, right?

For benefit 2), increasing compile coverage, could you tell more how it
achieves and why it matters? What if people disables CONFIG_KEXEC_CORE in
purpose? Please forgive my poor compiling knowledge.

Thanks
Baoquan



From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Mon, 9 May 2022 13:26:10 -0300
Subject: [PATCH 09/30] coresight: cpu-debug: Replace mutex with
 mutex_trylock on panic notifier
In-Reply-To: <d9ec6f31-6125-0723-b7d7-5898abeb3289@arm.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-10-gpiccoli@igalia.com>
 <3cafe4fd-8a0b-2633-44a3-2995abd6c38c@arm.com>
 <65f24bc5-2211-0139-ee12-b2608e81ceb1@igalia.com>
 <d9ec6f31-6125-0723-b7d7-5898abeb3289@arm.com>
Message-ID: <e4c71307-d59c-fec8-1fef-f67b86d5fb07@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 09/05/2022 13:14, Suzuki K Poulose wrote:
> [...]> 
> I have queued this to coresight/next.
> 
> Thanks
> Suzuki


Thanks a lot Suzuki!


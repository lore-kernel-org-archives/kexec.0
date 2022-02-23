From: Sergey Senozhatsky <senozhatsky@chromium.org>
Date: Wed, 23 Feb 2022 01:35:58 +0000
Subject: [PATCH V6] panic: Move panic_print before kmsg dumpers
In-Reply-To: <7702bdc2-78ce-00f5-d5a4-c06527c3ae72@igalia.com>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRAOQbH15E7y9s8@google.com>
 <7702bdc2-78ce-00f5-d5a4-c06527c3ae72@igalia.com>
Message-ID: <YhWPfqPlllm5XXHh@google.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On (22/02/22 11:08), Guilherme G. Piccoli wrote:
> Hi Sergey, thanks for your feedback. So, personally I prefer having the
> flag - for me it's clear, it's just a matter of reading the prototype -
> either we print the info _or_ we console_flush.
> 
> But let's see if others have a preference - if the preference is to use
> the bitmask as you suggest, we can do it in a next version.

Sounds good to me, thanks.


From: Luck, Tony <tony.luck@intel.com>
Date: Tue, 17 May 2022 19:07:54 +0000
Subject: [PATCH 21/30] panic: Introduce the panic pre-reboot notifier list
In-Reply-To: <62a63fc2-346f-f375-043a-fa21385279df@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-22-gpiccoli@igalia.com> <YoJgcC8c6LaKADZV@alley>
 <63a74b56-89ef-8d1f-d487-cdb986aab798@igalia.com>
 <bed66b9467254a5a8bafc1983dad643a@intel.com>
 <e895ce94-e6b9-caf6-e5d3-06bf0149445c@igalia.com> <YoOs9GJ5Ovq63u5Q@alley>
 <599b72f6-76a4-8e6d-5432-56fb1ffd7e0b@igalia.com>
 <06d85642fef24bc482642d669242654b@intel.com>
 <62a63fc2-346f-f375-043a-fa21385279df@igalia.com>
Message-ID: <7f9f6feb9f494b0288deab718807172d@intel.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

> What I'm planning to do in the altera_edac notifier is:
>
> if (kdump_is_set)
>   return;

Yes. That's what I think should happen.

-Tony

From: Luck, Tony <tony.luck@intel.com>
Date: Tue, 17 May 2022 17:02:31 +0000
Subject: [PATCH 21/30] panic: Introduce the panic pre-reboot notifier list
In-Reply-To: <599b72f6-76a4-8e6d-5432-56fb1ffd7e0b@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-22-gpiccoli@igalia.com> <YoJgcC8c6LaKADZV@alley>
 <63a74b56-89ef-8d1f-d487-cdb986aab798@igalia.com>
 <bed66b9467254a5a8bafc1983dad643a@intel.com>
 <e895ce94-e6b9-caf6-e5d3-06bf0149445c@igalia.com> <YoOs9GJ5Ovq63u5Q@alley>
 <599b72f6-76a4-8e6d-5432-56fb1ffd7e0b@igalia.com>
Message-ID: <06d85642fef24bc482642d669242654b@intel.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

> Tony / Dinh - can I just *skip* this notifier *if kdump* is set or else
> we run the code as-is? Does that make sense to you?

The "skip" option sounds like it needs some special flag associated with
an entry on the notifier chain. But there are other notifier chains ... so that
sounds messy to me.

Just all the notifiers in priority order. If any want to take different actions
based on kdump status, change the code. That seems more flexible than
an "all or nothing" approach by skipping.

-Tony
